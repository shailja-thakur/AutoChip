module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Define the states
parameter B = 0;
parameter A = 1;

// Define the present state and next state variables
reg [1:0] state, next_state;

// Define the output reg
reg out_reg;

// Define the state transition and output logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B; // Reset to state B
    end else begin
        state <= next_state; // Update the state
    end
end

always @(state, in) begin
    case (state)
        B: begin
            if (in == 1'b0) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        A: begin
            if (in == 1'b0) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
    endcase
end

always @(state) begin
    case (state)
        B: out_reg = 1'b0;
        A: out_reg = 1'b1;
    endcase
end

// Assign the output
assign out = out_reg; 

endmodule
