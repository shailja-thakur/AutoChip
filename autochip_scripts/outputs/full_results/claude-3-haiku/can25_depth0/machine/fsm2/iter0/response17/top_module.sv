module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

// Define the states
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Define the state register
reg state;

// Combinational logic to determine next state
always @(*) begin
    case (state)
        STATE_A: begin
            if (j) begin
                state = STATE_B;
            end else begin
                state = STATE_A;
            end
        end
        STATE_B: begin
            if (k) begin
                state = STATE_A;
            end else begin
                state = STATE_B;
            end
        end
        default: begin
            state = STATE_A;
        end
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end else begin
        state <= state;
    end
end

// Assign the output based on the current state
always @(*) begin
    if (state == STATE_B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
