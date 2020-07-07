# Hatena Blog Export

This is a Ruby script to export entries from [Hatena Blog](https://hatenablog.com/) for migrating to Jekyll.

## Prerequisites

Before you use the script, you need to have

- Ruby 2.7
- Bundler
- Hatena Blog ID
- Hatena Blog API Key

## Installation

Clone this repository:

```sh
git clone https://github.com/satoryu/hatenablog-export.git
cd hatenablog-export
```

Install gems:

```sh
bundle install
```

## Usage

```sh
bundle exec ruby export.rb \
  --user_id YOUR_HATENABLOG_USER_ID \
  --blog_id YOUR_HATENABLOG_BLOG_ID \
  --api_key YOUR_API_KEY
```

- `--user_id`, `-u`: Your Hatena Blog User ID, eg. `satoryu`
- `--blog_id`, `-b`: Your Hatena Blog Blog ID, eg. `satoryu.hatenablog.com`
- `--api_key`, `-k`: Your Hatena Blog API Key.

## License

This codes are under the MIT License.
See [this file](https://github.com/satoryu/hatenablog-export/blob/master/LICENSE).
