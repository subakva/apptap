require 'spec_helper'

describe 'apptap update' do
  it 'adds new formulae' do
    expect {
      add_local_formula
      call_apptap('update')
    }.to change { File.symlink?(brew_linked_formula_path) }.from(false).to(true)
  end

  it 'removes missing formulae' do
    add_local_formula
    call_apptap('update')

    expect {
      remove_local_formula
      call_apptap('update')
    }.to change { File.symlink?(brew_linked_formula_path) }.from(true).to(false)
  end

  it 'installs new services' do
    expect {
      add_local_formula
      add_config_with_formula
      call_apptap('update')
    }.to change { File.symlink?(brew_linked_formula_binary) }.from(false).to(true)
  end

  # it 'adds new services to the Procfile'
  # it 'uninstalls removed services'
  # it 'removes uninstalled services from the Procfile'
end
