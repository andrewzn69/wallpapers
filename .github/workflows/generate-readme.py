import os

# Directory containing the images
image_directory = 'previews'

# URL of the GitHub repository
github_repo_url = 'https://github.com/andrewzn69/wallpapers/tree/main/'


# Function to generate the README content
def generate_readme(directory):
    readme_content = "# Wallpapers\n\n"
    files = os.listdir(directory)

    for file in files:
        if file.endswith('.png'):
            # Create the links
            file_name, file_extension = os.path.splitext(file)
            print(file_name)
            readme_content += f"[{file_name}]({github_repo_url}{file})\n"
            readme_content += f"![{file_name}]({directory}/{file})\n---\n"

    return readme_content


# Generate the README content
readme_content = generate_readme(image_directory)

# Write the content to the README.md file
with open('README.md', 'w') as readme_file:
    readme_file.write(readme_content)

print("README.md generated successfully.")
