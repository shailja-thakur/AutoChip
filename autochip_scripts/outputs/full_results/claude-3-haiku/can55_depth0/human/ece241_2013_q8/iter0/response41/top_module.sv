module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        IDLE: begin
            z = 1'b0;
            if(x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = S1;
            end
        end
        S1: begin
            z = 1'b0;
            if(x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = S2;
            end
        end
        S2: begin
            z = 1'b0;
            if(x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = S3;
            end
        end
        S3: begin
            z = 1'b1;
            if(x == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            z = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
