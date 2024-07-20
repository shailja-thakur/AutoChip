module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
localparam [1:0] 
    S0 = 2'b00,
    S1 = 2'b01,
    S2 = 2'b10;

// Internal state register
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default next state
    next_state = S0;
    
    // Transition logic
    case (state)
        S0: begin
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S2;
            end
        end
        S2: begin
            if (x == 1'b0) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
    endcase
end

// Output logic
always @(*) begin
    if (state == S2 && x == 1'b1) begin
        z = 1'b1;
    end
    else begin
        z = 1'b0;
    end
end

endmodule
