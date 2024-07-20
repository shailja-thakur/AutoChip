module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] current_state, next_state;

localparam IDLE = 2'b00;
localparam DETECT_FIRST_1 = 2'b01;
localparam DETECT_0 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        current_state <= IDLE;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            IDLE: begin
                if (x) begin
                    next_state <= DETECT_FIRST_1;
                end
                else begin
                    next_state <= IDLE;
                end
                z <= 1'b0;
            end
            DETECT_FIRST_1: begin
                if (x) begin
                    next_state <= DETECT_0;
                end
                else begin
                    next_state <= IDLE;
                end
                z <= 1'b0;
            end
            DETECT_0: begin
                if (!x) begin
                    next_state <= IDLE;
                    z <= 1'b1;
                end
                else begin
                    next_state <= DETECT_FIRST_1;
                    z <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
