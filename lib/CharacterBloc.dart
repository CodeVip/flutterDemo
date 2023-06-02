import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:first_app/Character.dart';
import 'package:first_app/CharacterRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterEvent{
  @override
  List<Object> get props => [];
}

class
FetchCharactersEvent extends CharacterEvent {}



class CharacterState {
  final List<Character> characters;

  CharacterState({required this.characters});
}

class CharacterLoadingState extends CharacterState {
  CharacterLoadingState({required List<Character> characters})
      : super(characters: characters);
}

class CharacterLoadedState extends CharacterState {
  CharacterLoadedState({required List<Character> characters})
      : super(characters: characters);
}

class CharacterErrorState extends CharacterState {
  CharacterErrorState({required List<Character> characters})
      : super(characters: characters);
}



class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharacterRepository characterRepository;

  CharacterBloc({required this.characterRepository})
      : super(CharacterLoadingState(characters: []));



  @override
  Stream<CharacterState> mapEventToState(CharacterEvent event) async* {
    if (event is FetchCharactersEvent) {
      yield CharacterLoadingState(characters: []);

      try {
        final List<Character> characters =
        await characterRepository.getCharacters();
        yield CharacterLoadedState(characters: characters);
      } catch (e) {
        yield CharacterErrorState(characters: []);
      }
    }
    if (event is FetchMoreCharactersEvent) {
      yield state; // Keep the current state while loading more characters

      try {
        final List<Character> moreCharacters =
        await characterRepository.getCharacters();
        final List<Character> allCharacters = [...state.characters, ...moreCharacters];
        yield CharacterLoadedState(characters: allCharacters);
      } catch (e) {
        yield CharacterErrorState(characters: []);
      }
    }


  }
}

class FetchMoreCharactersEvent extends CharacterEvent {

}

class ApplyFiltersEvent extends CharacterEvent {
  final String name;
  final String status;
  final String species;

  ApplyFiltersEvent({required this.name, required this.status, required this.species});
}