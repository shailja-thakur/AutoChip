module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state;
parameter IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10, STATE3 = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
        z <= 0;
    end
    else begin
        case(state)
            IDLE: begin
                if(x == 1'b1) begin
                    state <= STATE1;
                    z <= 0;
                end
                else begin
                    state <= IDLE;
                    z <= 0;
                end
            end
            STATE1: begin
                if(x == 1'b0) begin
                    state <= STATE2;
                    z <= 0;
                end
                else begin
                    state <= STATE1;
                    z <= 0;
                end
            end
            STATE2: begin
                if(x == 1'b1) begin
                    state <= STATE3;
                    z <= 1;
                end
                else begin
                    state <= IDLE;
                    z <= 0;
                end
            end
            STATE3: begin
                if(x == 1'b0) begin
                    state <= IDLE;
                    z <= 0;
                end
                else begin
                    state <= STATE1;
                    z <= 0;
                end
            end
            default: begin
                state <= IDLE;
                z <= 0;
            end
        endcase
    end
end

endmodule
