using JuMP
import Ipopt

println("hello world")


#Define the model
model = Model(optimizer_with_attributes(Ipopt.Optimizer))
@variable(model, η[1:13, 1:4]>=0)

#Discount factor and initial distribution
γ = 0.999
μ = ones(13)/13

#Linear constraints
@constraint(model, sum(η[1, :]) - γ*(η[2, 2]) == (1-γ)*μ[1])
@constraint(model, sum(η[2, :]) - γ*(η[2, 3] + η[2, 4] + η[3, 2]) == (1-γ)*μ[2])
@constraint(model, sum(η[3, :]) - γ*(η[2, 1] + η[3, 3] + η[4, 2] + η[6, 3]) == (1-γ)*μ[3])
@constraint(model, sum(η[4, :]) - γ*(η[3, 1] + η[4, 3] + η[4, 4] + η[5, 2]) == (1-γ)*μ[4])
@constraint(model, sum(η[5, :]) - γ*(η[4, 1] + η[5, 3] + η[5, 4]) == (1-γ)*μ[5])
@constraint(model, sum(η[6, :]) - γ*(η[3, 4] + η[6, 1] + η[6, 2] + η[11, 3]) == (1-γ)*μ[6])
@constraint(model, sum(η[7, :]) - γ*(sum(η[1, :])/2 + η[7, 2] + η[7, 3] + η[7, 4] + η[8, 2]) == (1-γ)*μ[7])
@constraint(model, sum(η[8, :]) - γ*(η[7, 1] + η[8, 3] + η[8, 4] + η[9, 2] + η[12, 3]) == (1-γ)*μ[8])
@constraint(model, sum(η[9, :]) - γ*(η[8, 1] + η[9, 3] + η[10, 2]) == (1-γ)*μ[9])
@constraint(model, sum(η[10, :]) - γ*(η[9, 1] + η[10, 3] + η[10, 4] + η[11, 2]) == (1-γ)*μ[10])
@constraint(model, sum(η[11, :]) - γ*(η[6, 4] + η[10, 1] + η[11, 1] + η[11, 4]) == (1-γ)*μ[11])
@constraint(model, sum(η[12, :]) - γ*(η[9, 4] + η[12, 1] + η[12, 2] + η[13, 3]) == (1-γ)*μ[12])
@constraint(model, sum(η[13, :]) - γ*(sum(η[1, :])/2 + η[12, 4] + η[13, 1] + η[13, 2] + η[13, 4]) == (1-γ)*μ[13])
#Polynomial constraints
@constraint(model, [i in 1:4], η[7, i] * sum(η[1, :]) - η[1, i] * sum(η[7, :]) == 0)
@constraint(model, [i in 1:4], η[8, i] * sum(η[3, :]) - η[3, i] * sum(η[8, :]) == 0)
@constraint(model, [i in 1:4], η[12, i] * sum(η[6, :]) - η[6, i] * sum(η[12, :]) == 0)
@constraint(model, [i in 1:4], η[4, i] * sum(η[2, :]) - η[2, i] * sum(η[4, :]) == 0)
@constraint(model, [i in 1:4], η[9, i] * sum(η[2, :]) - η[2, i] * sum(η[9, :]) == 0)
@constraint(model, [i in 1:4], η[10, i] * sum(η[2, :]) - η[2, i] * sum(η[10, :]) == 0)

#Define the objective
@NLobjective(model, Max, η[1, 1] + η[1, 2] + η[1, 3] + η[1, 4])

#Optimize
optimize!(model)using JuMP
import Ipopt

#Define the model
model = Model(optimizer_with_attributes(Ipopt.Optimizer))
@variable(model, η[1:13, 1:4]>=0)

#Discount factor and initial distribution
γ = 0.999
μ = ones(13)/13

#Linear constraints
@constraint(model, sum(η[1, :]) - γ*(η[2, 2]) == (1-γ)*μ[1])
@constraint(model, sum(η[2, :]) - γ*(η[2, 3] + η[2, 4] + η[3, 2]) == (1-γ)*μ[2])
@constraint(model, sum(η[3, :]) - γ*(η[2, 1] + η[3, 3] + η[4, 2] + η[6, 3]) == (1-γ)*μ[3])
@constraint(model, sum(η[4, :]) - γ*(η[3, 1] + η[4, 3] + η[4, 4] + η[5, 2]) == (1-γ)*μ[4])
@constraint(model, sum(η[5, :]) - γ*(η[4, 1] + η[5, 3] + η[5, 4]) == (1-γ)*μ[5])
@constraint(model, sum(η[6, :]) - γ*(η[3, 4] + η[6, 1] + η[6, 2] + η[11, 3]) == (1-γ)*μ[6])
@constraint(model, sum(η[7, :]) - γ*(sum(η[1, :])/2 + η[7, 2] + η[7, 3] + η[7, 4] + η[8, 2]) == (1-γ)*μ[7])
@constraint(model, sum(η[8, :]) - γ*(η[7, 1] + η[8, 3] + η[8, 4] + η[9, 2] + η[12, 3]) == (1-γ)*μ[8])
@constraint(model, sum(η[9, :]) - γ*(η[8, 1] + η[9, 3] + η[10, 2]) == (1-γ)*μ[9])
@constraint(model, sum(η[10, :]) - γ*(η[9, 1] + η[10, 3] + η[10, 4] + η[11, 2]) == (1-γ)*μ[10])
@constraint(model, sum(η[11, :]) - γ*(η[6, 4] + η[10, 1] + η[11, 1] + η[11, 4]) == (1-γ)*μ[11])
@constraint(model, sum(η[12, :]) - γ*(η[9, 4] + η[12, 1] + η[12, 2] + η[13, 3]) == (1-γ)*μ[12])
@constraint(model, sum(η[13, :]) - γ*(sum(η[1, :])/2 + η[12, 4] + η[13, 1] + η[13, 2] + η[13, 4]) == (1-γ)*μ[13])
#Polynomial constraints
@constraint(model, [i in 1:4], η[7, i] * sum(η[1, :]) - η[1, i] * sum(η[7, :]) == 0)
@constraint(model, [i in 1:4], η[8, i] * sum(η[3, :]) - η[3, i] * sum(η[8, :]) == 0)
@constraint(model, [i in 1:4], η[12, i] * sum(η[6, :]) - η[6, i] * sum(η[12, :]) == 0)
@constraint(model, [i in 1:4], η[4, i] * sum(η[2, :]) - η[2, i] * sum(η[4, :]) == 0)
@constraint(model, [i in 1:4], η[9, i] * sum(η[2, :]) - η[2, i] * sum(η[9, :]) == 0)
@constraint(model, [i in 1:4], η[10, i] * sum(η[2, :]) - η[2, i] * sum(η[10, :]) == 0)

#Define the objective
@NLobjective(model, Max, η[1, 1] + η[1, 2] + η[1, 3] + η[1, 4])

#Optimize
optimize!(model)

#Compute the state policy
τ = zeros((13, 4))
for i = 1:13
    τ[i, :] = JuMP.value.(η)[i, :] / sum(JuMP.value.(η)[i, :])
end

#Observation kernel
β = [1 0 0 0 0 0 0
     0 1 0 0 0 0 0
     0 0 1 0 0 0 0
     0 1 0 0 0 0 0
     0 0 0 1 0 0 0
     0 0 0 0 1 0 0
     1 0 0 0 0 0 0
     0 1 0 0 0 0 0
     0 0 1 0 0 0 0
     0 1 0 0 0 0 0
     0 0 0 0 0 1 0
     0 0 0 0 1 0 0
     0 0 0 0 0 0 1]

#Compute the observation policy
π = inv(transpose(β)*β)*transpose(β)*τ

# Print the solve time of Ipopt
println("Solve time of Ipopt: ", solve_time(model))


#Compute the state policy
τ = zeros((13, 4))
for i = 1:13
    τ[i, :] = JuMP.value.(η)[i, :] / sum(JuMP.value.(η)[i, :])
end

#Observation kernel
β = [1 0 0 0 0 0 0
     0 1 0 0 0 0 0
     0 0 1 0 0 0 0
     0 1 0 0 0 0 0
     0 0 0 1 0 0 0
     0 0 0 0 1 0 0
     1 0 0 0 0 0 0
     0 1 0 0 0 0 0
     0 0 1 0 0 0 0
     0 1 0 0 0 0 0
     0 0 0 0 0 1 0
     0 0 0 0 1 0 0
     0 0 0 0 0 0 1]

#Compute the observation policy
π = inv(transpose(β)*β)*transpose(β)*τ

# Print the solve time of Ipopt
println("Solve time of Ipopt: ", solve_time(model))
