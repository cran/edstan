data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
}
parameters {
  vector[I] beta;
  vector[J] theta;
  real<lower=1> sigma;
}
model {
  beta ~ normal(0, 3);
  theta ~ normal(0, sigma);
  sigma ~ exponential(.1);
  y ~ bernoulli_logit(theta[jj] - beta[ii]);
}
