<?php

namespace Pterodactyl\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Pterodactyl\Services\EmailUtils\EmailTemplateManager;

class RemovedFromServer extends Notification implements ShouldQueue
{
    use Queueable;

    public object $server;

    /**
     * Create a new notification instance.
     */
    public function __construct(array $server)
    {
        $this->server = (object) $server;
    }

    /**
     * Get the notification's delivery channels.
     */
    public function via(): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(mixed $notifiable = null): MailMessage
    {
        $message = (new MailMessage())
            ->error()
            ->greeting('Hello ' . $this->server->user . '.')
            ->line('You have been removed as a subuser for the following server.')
            ->line('Server Name: ' . $this->server->name)
            ->action('Visit Panel', route('index'));
            return EmailTemplateManager::applyFromNotification($this, $notifiable, $message);
    }
}
