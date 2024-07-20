module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011; // Final state

always_ff @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

always_comb begin
    next_state = state;
    
    case(state)
        S0: begin
            if (x == 1'b1) begin
                next_state = S1;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S2;
            end
        end
        S2: begin
            if (x == 1'b1) begin
                next_state = S3;
            end
        end
        S3: begin
            next_state = S0;
        end
    endcase
end

always_comb begin
    case(state)
        S3: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
