#!/usr/bin/env nextflow
nextflow.preview.dsl=2

params.events = 'create'
params.paths = 'examples/data/*.fa'


process align {
  input:
  path fasta

  output:
  path aln

  """
  t_coffee -in $fasta 1> aln
  """
}

/*
 * main flow
 */
 
Channel
    .watchPath(params.files, params.events) \
    | align \
    | subscribe {
          println '------'
          println it.text
        }
