module top_module(
    input clk,
    input in,
    input reset,
    output out
);

// Define states as enum
typedef enum logic[1:0] {
    A,
    B,
    C,
    D
} state_t;

// Define state register
reg [1:0] current_state, next_state;

// Define output register
reg out_reg;

// Assign current state to next state
// at positive edge of the clock
always @(posedge clk) begin
    if (reset) begin
        next_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Assign outputs based on the current state
always @(current_state) begin
    case (current_state)
        A: begin
            out_reg <= 0;
            if (in)
                next_state <= B;
            else
                next_state <= A;
        end
        B: begin
            out_reg <= 0;
            if (in)
                next_state <= B;
            else
                next_state <= C;
        end
        C: begin
            out_reg <= 0;
            if (in)
                next_state <= D;
            else
                next_state <= A;
        end
        D: begin
            out_reg <= 1;
            if (in)
                next_state <= B;
            else
                next_state <= C;
        end
    endcase
end

// Assign output to the desired output
assign out = out_reg;

endmodule
