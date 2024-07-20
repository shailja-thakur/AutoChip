module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);

reg [2:0] state;
reg [7:0] last_in;


always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
    end else begin
        case (state)
            0: begin
                if (in[3] == 1) begin
                    state <= 1;
                end
            end
            1: begin
                state <= 2;
            end
            2: begin
                state <= 3;
            end
            3: begin
                state <= 0;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        last_in <= 0;
    end else begin
        last_in <= in;
    end
end

assign done = (state == 3) && (last_in[3] == 1);

endmodule
