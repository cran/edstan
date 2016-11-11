data {
  int<lower=1> I;               // # questions
  int<lower=1> J;               // # persons
  int<lower=1> N;               // # observations
  int<lower=1, upper=I> ii[N];  // question for n
  int<lower=1, upper=J> jj[N];  // person for n
  int<lower=0, upper=1> y[N];   // correctness for n
}
parameters {
  vector[I-1] beta_free;
  vector[J] theta;
  real<lower=1> sigma;
  real lambda;
}
transformed parameters {
  vector[I] beta;
  beta[1:(I-1)] = beta_free;
  beta[I] = -1*sum(beta_free);
}
model {
  beta_free ~ normal(0, 3);
  lambda ~ student_t(1, 0, 1);
  theta ~ normal(lambda, sigma);
  sigma ~ exponential(.1);
  y ~ bernoulli_logit(theta[jj] - beta[ii]);
}
