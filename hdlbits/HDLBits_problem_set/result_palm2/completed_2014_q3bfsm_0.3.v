module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    reg [1:0] state;
    reg [1:0] y;
    reg z;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            case (state)
                3'b000:
                    if (x == 0) begin
                        state <= 3'b001;
                    elsif (x == 1) begin
                        state <= 3'b010;
                    endif
                3'b001:
                    if (x == 0) begin
                        state <= 3'b011;
                    elsif (x == 1) begin
                        state <= 3'b100;
                    endif
                3'b010:
                    if (x == 0) begin
                        state <= 3'b001;
                    elsif (x == 1) begin
                        state <= 3'b010;
                    endif
                3'b011:
                    if (x == 0) begin
                        state <= 3'b001;
                    elsif (x == 1) begin
                        state <= 3'b010;
                    endif
                3'b100:
                    if (x == 0) begin
                        state <= 3'b011;
                    elsif (x == 1) begin
                        state <= 3'b100;
                    endif
            endcase
        end
    end

    always @(posedge clk) begin
        y <= state;
    end

    always @(posedge clk) begin
        z <= (y[1] == 1);
    end

endmodule