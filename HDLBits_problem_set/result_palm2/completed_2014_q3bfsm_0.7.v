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
            y <= 3'b000;
        end else begin
            case (state)
                3'b000: begin
                    if (x == 0) begin
                        y <= 3'b001;
                        z <= 0;
                    end else begin
                        y <= 3'b001;
                        z <= 1;
                    end
                end
                3'b001: begin
                    if (x == 0) begin
                        y <= 3'b100;
                        z <= 0;
                    end else begin
                        y <= 3'b100;
                        z <= 1;
                    end
                end
                3'b010: begin
                    if (x == 0) begin
                        y <= 3'b001;
                        z <= 0;
                    end else begin
                        y <= 3'b001;
                        z <= 1;
                    end
                end
                3'b011: begin
                    if (x == 0) begin
                        y <= 3'b010;
                        z <= 0;
                    end else begin
                        y <= 3'b010;
                        z <= 1;
                    end
                end
                3'b100: begin
                    if (x == 0) begin
                        y <= 3'b111;
                        z <= 0;
                    end else begin
                        y <= 3'b111;
                        z <= 1;
                    end
                end
            endcase
        end
    end

endmodule