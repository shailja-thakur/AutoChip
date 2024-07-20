module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

reg current_state, next_state;

// combinational always block to determine the next state
always @ *
    if (current_state == 1'b0) begin
        if (j == 1'b1) begin
            next_state = 1'b1;
        end else begin
            next_state = 1'b0;
        end
    end else begin
        if (k == 1'b1) begin
            next_state = 1'b0;
        end else begin
            next_state = 1'b1;
        end
    end

// clocked always block to update the state based on areset and next state
always @(posedge clk or posedge areset)
    if (areset == 1'b1) begin
        current_state <= 1'b0;
    end else begin
        current_state <= next_state;
    end

// output the current state
assign out = current_state;

endmodule
