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
    
    reg [1:0] state, next_state;    
    
    // Define state transition table
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    // Define next state logic and output logic
    always @* begin
        case (state)
            S: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
                z = 0;
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
                z = 0;
            end
            S10: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
                z = x;
            end
        endcase
    end
    
endmodule
