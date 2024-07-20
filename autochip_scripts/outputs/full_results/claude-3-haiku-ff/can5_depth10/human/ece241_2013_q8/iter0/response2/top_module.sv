module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00, FIRST_1 = 2'b01, SECOND_0 = 2'b10, FOUND = 2'b11;

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
            if (x) begin
                next_state = FIRST_1;
            end else begin
                next_state = IDLE;
            end
            z = 1'b0;
        end
        FIRST_1: begin
            if (!x) begin
                next_state = SECOND_0;
            end else begin
                next_state = FIRST_1;
            end
            z = 1'b0;
        end
        SECOND_0: begin
            if (x) begin
                next_state = FOUND;
            end else begin
                next_state = IDLE;
            end
            z = 1'b0;
        end
        FOUND: begin
            next_state = IDLE;
            z = 1'b1;
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
