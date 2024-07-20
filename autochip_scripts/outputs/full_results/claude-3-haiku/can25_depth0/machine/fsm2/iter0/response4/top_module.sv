module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Declare the state variables
reg state, next_state;

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: begin
            if (j) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (k) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Sequential logic to update the current state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Assign the output based on the current state
always @(*) begin
    if (state == B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
