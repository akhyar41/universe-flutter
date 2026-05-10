import "package:flutter/material.dart";

import "../../../../../core/utils/date_formatter.dart";
import "../../../../../data/models/meeting_note_model.dart";
import "../../../themes/app_colors.dart";
import "../../../themes/app_text_styles.dart";

class MeetingCard extends StatelessWidget {
  final MeetingNoteModel meeting;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const MeetingCard({super.key, required this.meeting, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(meeting.title, style: AppTextStyles.h3, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.error),
                    onPressed: onDelete,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text("${DateFormatter.toDisplayDate(meeting.date)}  ${meeting.time}", style: AppTextStyles.bodySmall),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      meeting.location,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (meeting.participants.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: meeting.participants
                      .take(3)
                      .map(
                        (p) => Chip(
                          label: Text(p, style: const TextStyle(fontSize: 11)),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          side: BorderSide.none,
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
