module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam S = 2'd0;
localparam S1 = 2'd1;
localparam S10 = 2'd2;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        S: begin
            if (x == 1'b0) begin
                next_state = S;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S10;
            end
            else begin
                next_state = S1;
            end
        end
        S10: begin
            if (x == 1'b0) begin
                next_state = S;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            next_state = S;
        end
    endcase
end

always @(*) begin
    case (state)
        S: begin
            z = 1'b0;
        end
        S1: begin
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
