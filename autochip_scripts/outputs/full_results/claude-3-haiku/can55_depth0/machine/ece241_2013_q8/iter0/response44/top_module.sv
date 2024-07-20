module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    reg [1:0] state, next_state;
    parameter S = 2'b00, S1 = 2'b01, S10 = 2'b10;

    always @(posedge clk or negedge aresetn) begin
        if(!aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            S: begin
                if(x == 1'b0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
            end
            S1: begin
                if(x == 1'b0) begin
                    next_state = S10;
                end else begin
                    next_state = S1;
                end
            end
            S10: begin
                if(x == 1'b0) begin
                    next_state = S;
                end else begin
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
