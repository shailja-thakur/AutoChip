module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
localparam IDLE = 2'b00, FIRST_1 = 2'b01, SECOND_0 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            z = 0;
            if (x) begin
                next_state = FIRST_1;
            end else begin
                next_state = IDLE;
            end
        end
        FIRST_1: begin
            z = 0;
            if (~x) begin
                next_state = SECOND_0;
            end else begin
                next_state = FIRST_1;
            end
        end
        SECOND_0: begin
            if (x) begin
                z = 1;
                next_state = FIRST_1;
            end else begin
                z = 0;
                next_state = IDLE;
            end
        end
        default: begin
            z = 0;
            next_state = IDLE;
        end
    endcase
end

endmodule
