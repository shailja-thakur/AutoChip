module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00,
          DETECT_1 = 2'b01,
          DETECT_01 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                z <= 1'b0;
            end
            DETECT_1: begin
                if (x) begin
                    z <= 1'b1;
                end
                else begin
                    z <= 1'b0;
                end
            end
            DETECT_01: begin
                if (x) begin
                    z <= 1'b1;
                end
                else begin
                    z <= 1'b0;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x) begin
                next_state = DETECT_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_1: begin
            if (x) begin
                next_state = DETECT_01;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT_01: begin
            if (x) begin
                next_state = DETECT_1;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
