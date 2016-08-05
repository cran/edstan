data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
  int<lower=1> K;               // # person covariates
  matrix[J,K] W;                // person covariate matrix
}
parameters {
  vector[I-1] beta_free;
  vector[J] theta;
  real<lower=0> sigma;
  vector[K] lambda;
}
transformed parameters {
  vector[I] beta;
  beta = append_row(beta_free, rep_vector(-1*sum(beta_free), 1));
}
model {
  target += normal_lpdf(beta_free | 0, 5);
  target += normal_lpdf(theta |W*lambda, sigma);
  target += exponential_lpdf(sigma | .1);
  target += bernoulli_logit_lpmf(y | theta[jj] - beta[ii]);
}
