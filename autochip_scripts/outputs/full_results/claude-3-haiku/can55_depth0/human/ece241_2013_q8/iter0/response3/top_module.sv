module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam FOUND_1 = 2'b01;
localparam FOUND_01 = 2'b11;

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
            z = 1'b0;
            if (x) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_1: begin
            z = 1'b0;
            if (x) begin
                next_state = FOUND_01;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND_01: begin
            z = 1'b1;
            if (x) begin
                next_state = FOUND_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            z = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
