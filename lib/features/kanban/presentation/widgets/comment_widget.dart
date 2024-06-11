import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_app/features/kanban/data/dto/update_comment_dto.dart';
import 'package:task_manager_app/features/kanban/domain/entities/comment.dart';
import 'package:task_manager_app/features/kanban/presentation/cubit/comment_cubit/comment_cubit.dart';

///======================================================================================================
/// Widget for displaying a comment associated with a task.
///
/// This widget displays a comment with the user's avatar, content, and posting date. It provides options
/// to edit or delete the comment. When editing a comment, it opens a dialog to enter the updated comment
/// content.
///
/// Parameters:
///   - `comment`: The comment to display.
///======================================================================================================

class CommentWidget extends StatefulWidget {
  final Comment comment;

  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late TextEditingController commentController;
  @override
  void initState() {
    commentController = TextEditingController(text: widget.comment.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 20),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.comment.content ?? '',
                ),
                const SizedBox(height: 5),
                Text(
                  _formatDate(widget.comment.postedAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              _showEditDialog(context, widget.comment);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              context.read<CommentBloc>().deleteComment(widget.comment);
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    final dateTime = DateTime.parse(dateStr);
    final dateFormat = DateFormat('d MMMM \'at\' hh:mm a');
    return dateFormat.format(dateTime);
  }

  void _showEditDialog(BuildContext context, Comment comment) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            maxLines: 100,
            minLines: 1,
            controller: commentController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<CommentBloc>().updateComment(id: comment.id!, updateCommentDto: UpdateCommentDto(content: commentController.text));
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
