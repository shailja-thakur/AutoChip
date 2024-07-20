module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// States of the FSM
localparam [1:0] 
    S0 = 2'b00, // Initial state
    S1 = 2'b01, // Detected first '1'
    S2 = 2'b10; // Detected '01'

// State register
reg [1:0] state, next_state;

// Next state logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// State transition logic
always @(*) begin
    case (state)
        S0: begin
            if (x == 1'b1) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S2;
            end else begin
                next_state = S1;
            end
        end
        S2: begin
            if (x == 1'b1) begin
                next_state = S1;
                z = 1'b1;
            end else begin
                next_state = S0;
                z = 1'b0;
            end
        end
        default: begin
            next_state = S0;
            z = 1'b0;
        end
    endcase
end

endmodule
