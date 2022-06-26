// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_categories_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoCategoriesAdapter extends TypeAdapter<TodoCategories> {
  @override
  final int typeId = 1;

  @override
  TodoCategories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoCategories(
      id: fields[1] as int?,
      categoryName: fields[2] as String?,
      categoryColorId: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, TodoCategories obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.categoryName)
      ..writeByte(3)
      ..write(obj.categoryColorId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoCategoriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
