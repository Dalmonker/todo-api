-- Таблица пользователей
CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       email VARCHAR(255) UNIQUE NOT NULL, -- UNIQUE - не может быть пользователя с email который уже существует
                       password_hash VARCHAR(255) NOT NULL,
                       name VARCHAR(100),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица задач (ОСНОВНАЯ)
CREATE TABLE tasks (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       user_id INT NOT NULL,
                       title VARCHAR(255) NOT NULL,
                       description TEXT, -- В отличие от VARCHAR, TEXT не имеет ограничения длины в скобках
                       status ENUM('todo', 'in_progress', 'done') DEFAULT 'todo',
                       priority ENUM('low', 'medium', 'high') DEFAULT 'medium',
                       due_date DATE,                             -- Срок выполнения
                       completed_at TIMESTAMP NULL,               -- Когда выполнена
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE, -- ON DELETE CASCADE — каскадное удаление: Если удаляем пользователя → автоматически удаляем ВСЕ его задачи
                       INDEX idx_user_status (user_id, status),
                       INDEX idx_due_date (due_date)
);

-- Таблица тегов (для меток)
CREATE TABLE tags (
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      user_id INT NOT NULL,
                      name VARCHAR(50) NOT NULL,
                      color VARCHAR(7) DEFAULT '#3498db',
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      UNIQUE KEY unique_user_tag (user_id, name), -- Один тег на пользователя
                      FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- (многие-ко-многим)
CREATE TABLE task_tags (
                           task_id INT NOT NULL,
                           tag_id INT NOT NULL,
                           PRIMARY KEY (task_id, tag_id),
                           FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
                           FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);