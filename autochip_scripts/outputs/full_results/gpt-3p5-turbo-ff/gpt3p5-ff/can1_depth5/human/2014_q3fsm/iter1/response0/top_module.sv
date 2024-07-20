module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
reg [2:0] w_count; // Counter to keep track of w values

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00; // reset state A
        w_count <= 3'b000;
    end else begin
        case (state)
            2'b00: begin // state A
                if (s) begin
                    state <= 2'b01; // move to state B
                end
            end
            2'b01: begin // state B
                if (w_count == 3'b000) begin
                    state <= 2'b10; // transition to next state
                end else begin
                    w_count <= w_count + 1;
                end
            end
            2'b10: begin // check w for 3 cycles
                if (w_count == 3'b011 && w) begin
                    state <= 2'b11;
                    w_count <= 3'b000;
                end else begin
                    w_count <= w_count + 1;
                end
            end
            2'b11: begin // check w for 3 cycles
                if (w_count == 3'b011) begin
                    state <= 2'b00;
                    w_count <= 3'b000;
                end else begin
                    w_count <= w_count + 1;
                end
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == 2'b11) begin
        if (w && (w_count[2] == 1) && (w_count[1] == 1)) begin
            z <= 1;
        end else begin
            z <= 0;
        end
    end
end

endmodule
