module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

reg [1:0] state, next_state;

// Initial state
always @(posedge clk) begin
    if (reset)
        state <= 2'b00; // A
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        2'b00: begin // A
            if (j)
                next_state = 2'b01; // B
            else
                next_state = 2'b00; // A
        end
        2'b01: begin // B
            if (k)
                next_state = 2'b00; // A
            else
                next_state = 2'b01; // B
        end
        default: next_state = 2'b00; // A (in case of unknown state)
    endcase
end

// Output logic
assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
