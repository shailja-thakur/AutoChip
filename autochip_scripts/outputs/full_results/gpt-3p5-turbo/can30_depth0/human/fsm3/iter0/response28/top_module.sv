module top_module (
	input clk,
	input in,
	input areset,
	output out
);
    // Define the states as parameters
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Define the state register
    reg [1:0] state_reg;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state_reg <= A;
        else begin
            case (state_reg)
                A: if (in)
                       state_reg <= B;
                   else
                       state_reg <= A;
                B: if (in)
                       state_reg <= B;
                   else
                       state_reg <= C;
                C: if (in)
                       state_reg <= D;
                   else
                       state_reg <= A;
                D: if (in)
                       state_reg <= B;
                   else
                       state_reg <= C;
            endcase
        end
    end

    // Define the output logic
    always @(state_reg) begin
        case (state_reg)
            A: out = 1'b0;
            B: out = 1'b0;
            C: out = 1'b0;
            D: out = 1'b1;
        endcase
    end

endmodule
