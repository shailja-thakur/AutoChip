module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state;
reg [2:0] next_state;
assign z = (state == 3);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state)
        0: begin
            if (w) begin
                next_state = 0;
            end else begin
                next_state = 1;
            end
        end
        1: begin
            if (w) begin
                next_state = 3;
            end else begin
                next_state = 0;
            end
        end
        2: begin
            if (w) begin
                next_state = 3;
            end else begin
                next_state = 4;
            end
        end
        3: begin
            if (w) begin
                next_state = 1;
            end else begin
                next_state = 5;
            end
        end
        4: begin
            if (w) begin
                next_state = 6;
            end else begin
                next_state = 5;
            end
        end
        5: begin
            if (w) begin
                next_state = 1;
            end else begin
                next_state = 3;
            end
        end
        6: begin
            if (w) begin
                next_state = 2;
            end else begin
                next_state = 4;
            end
        end
    endcase
end

endmodule
