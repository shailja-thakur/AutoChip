module top_module (
    input wire clk,
    input wire reset,
    input wire data,
    output reg start_shifting
);

reg [3:0] state;
reg [3:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        start_shifting <= 0;
    end else begin
        state <= next_state;
    end
end

always @(state or data) begin
    case (state)
        0: begin
            if (data) begin
                next_state = 1;
            end
        end
        1: begin
            if (data) begin
                next_state = 2;
            end
        end
        2: begin
            if (data) begin
                next_state = 3;
            end
        end
        3: begin
            if (data) begin
                next_state = 4;
                start_shifting = 1;
            end else begin
                next_state = 0;
                start_shifting = 0;
            end
        end
        4: begin
            next_state = 0;
        end
        default: begin
            next_state = 0;
        end
    endcase
end

endmodule
