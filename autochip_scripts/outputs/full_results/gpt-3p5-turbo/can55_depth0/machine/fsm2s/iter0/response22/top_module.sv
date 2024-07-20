module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin  // A state
            if (j) begin
                next_state = 2'b01;  // Transition to B state
            end else begin
                next_state = 2'b00;  // Stay in A state
            end
        end
        
        2'b01: begin  // B state
            if (k) begin
                next_state = 2'b00;  // Transition to A state
            end else begin
                next_state = 2'b01;  // Stay in B state
            end
        end
    endcase
end

// Output assignment
always @(state) begin
    if (state == 2'b01) begin
        out = 1'b1;  // Output is high when state is B
    end else begin
        out = 1'b0;  // Output is low when state is A
    end
end

endmodule
