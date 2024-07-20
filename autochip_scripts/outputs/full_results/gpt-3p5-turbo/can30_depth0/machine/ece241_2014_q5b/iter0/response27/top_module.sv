module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// State definitions
parameter A = 1'b0;
parameter B = 1'b1;

reg state;

// Positive edge detection
reg prev_x;
always @(posedge clk or negedge areset) begin
    if (!areset) begin
        state <= A;
    end else begin
        prev_x <= x;
        if (state == A) begin
            if (x == 1'b1) begin
                state <= B;
            end
        end else if (state == B) begin
            state <= B;
        end
    end
end

// Output assignment
always @(state or x) begin
    if (state == A && x == 1'b1) begin
        z <= 1'b1;
    end else if (state == B && x == 1'b0) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
