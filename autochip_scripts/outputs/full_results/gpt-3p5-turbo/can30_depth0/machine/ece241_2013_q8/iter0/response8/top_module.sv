module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define states
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

// Define state registers
reg [1:0] current_state;
reg [1:0] next_state;

// Define state assignment rules
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        current_state <= S;
    end else begin
        current_state <= next_state;
    end
end

// Define next state logic
always @(current_state, x) begin
    case (current_state)
        S: begin
            if (x == 1'b0) begin
                next_state <= S;
            end else begin
                next_state <= S1;
            end
        end
        
        S1: begin
            if (x == 1'b0) begin
                next_state <= S10;
            end else begin
                next_state <= S1;
            end
        end
        
        S10: begin
            if (x == 1'b0) begin
                next_state <= S;
            end else begin
                next_state <= S1;
            end
        end
        
        default: next_state <= S;
    endcase
end

// Define output logic
always @(current_state, x) begin
    case (current_state)
        S, S1: z <= 1'b0;
        S10: z <= x;
    endcase
end

endmodule
