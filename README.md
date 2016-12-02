# fakecm
A fake coupled model for Oasis testing

# Usage
Grab a `namcouple` file, put it in this directory. Running `process.sh` will extract field names from the namcouple file (it uses restart file names to assign fields to models)

`make` will then build the fake model

You may need to mess about inside `main.F90` to get each model sending/receiving in the correct order as in the full model

You can then run the fake model as desired to play with oasis sequencing etc., without the hassle of running a full model.

# Use cases

 * Check coupled field sequencing

 * Mock out components while debugging a single model
