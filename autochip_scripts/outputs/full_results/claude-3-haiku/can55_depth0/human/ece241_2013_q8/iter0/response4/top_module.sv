module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam CHECK_1 = 2'b01;
localparam CHECK_0 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x) begin
                next_state = CHECK_1;
                z = 1'b0;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        CHECK_1: begin
            if (x) begin
                next_state = CHECK_0;
                z = 1'b0;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        CHECK_0: begin
            if (x) begin
                next_state = CHECK_1;
                z = 1'b1;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
