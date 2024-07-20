module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z,
    reg [1:0] state,
    wire [1:0] state_next
);

// State definitions
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S;
    end else begin
        state <= state_next;
    end
end

// Next state logic
always @(state or x) begin
    case (state)
        S: begin
            if (x == 1'b0) begin
                state_next = S;
            end else begin
                state_next = S1;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                state_next = S10;
            end else begin
                state_next = S1;
            end
        end
        S10: begin
            if (x == 1'b0) begin
                state_next = S;
            end else begin
                state_next = S1;
            end
        end
        default: begin
            state_next = S;
        end
    endcase
end

// Output logic
always @(state) begin
    case (state)
        S, S1: begin
            z = 1'b0;
        end
        S10: begin
            z = x;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
