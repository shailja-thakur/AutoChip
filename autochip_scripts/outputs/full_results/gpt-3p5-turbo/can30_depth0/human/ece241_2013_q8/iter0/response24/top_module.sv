module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	
// State declaration
reg [1:0] state, next_state;

// State parameter declaration
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

// Transition conditions
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case(state)
        S0: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        S1: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S2;
            end
        end
        S2: begin
            if (x) begin
                next_state = S1;
                z = 1'b1;
            end else begin
                next_state = S0;
                z = 1'b0;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
