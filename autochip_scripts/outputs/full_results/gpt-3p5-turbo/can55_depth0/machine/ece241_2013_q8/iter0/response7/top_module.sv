module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states
    parameter S = 3'b000;
    parameter S1 = 3'b001;
    parameter S10 = 3'b010;
    
    // Define next states
    reg [2:0] state;
    reg [2:0] next_state;
    
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or x) begin
        case (state)
            S: begin
                if (x == 1'b0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = 1'b0;
            end
            S1: begin
                if (x == 1'b0) begin
                    next_state = S10;
                end else begin
                    next_state = S1;
                end
                z = 1'b0;
            end
            S10: begin
                if (x == 1'b0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = x;
            end
            default: begin
                next_state = S;
                z = 1'b0;
            end
        endcase
    end

endmodule
