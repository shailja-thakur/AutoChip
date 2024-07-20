module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam S  = 2'b00;
localparam S1 = 2'b01;
localparam S10 = 2'b10;

// State transition logic
always @(*) begin
    case (state)
        S: begin
            if (x == 1'b0) next_state = S;
            else next_state = S1;
        end
        S1: begin
            if (x == 1'b0) next_state = S10;
            else next_state = S1;
        end
        S10: begin
            if (x == 1'b0) next_state = S;
            else next_state = S1;
        end
        default: next_state = S;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S: z = 1'b0;
        S1: z = 1'b0;
        S10: z = x;
        default: z = 1'b0;
    endcase
end

// Sequential logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

endmodule
