module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state;
    reg [5:0] count;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
            count <= 6'b000_000;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case (state)
                3'b000: begin
                    if (in == 1'b1) begin
                        count <= count + 1'b1;
                        if (count == 6'b011_111) begin
                            count <= 6'b000_000;
                            disc <= 1'b1;
                            state <= 3'b001;
                        end else if (count == 6'b011_1111) begin
                            count <= 6'b000_000;
                            flag <= 1'b1;
                            state <= 3'b010;
                        end
                    end else begin
                        count <= 6'b000_000;
                    end
                end
                3'b001: begin
                    if (in == 1'b0) begin
                        state <= 3'b000;
                    end else if (in == 1'b1) begin
                        count <= count + 1'b1;
                        if (count >= 6'b011_1111) begin
                            count <= 6'b000_000;
                            err <= 1'b1;
                            state <= 3'b011;
                        end
                    end
                end
                3'b010: begin
                    if (in == 1'b0) begin
                        state <= 3'b000;
                    end else if (in == 1'b1) begin
                        count <= count + 1'b1;
                        if (count >= 6'b011_1111) begin
                            count <= 6'b000_000;
                            err <= 1'b1;
                            state <= 3'b011;
                        end
                    end
                end
                3'b011: begin
                    if (in == 1'b0) begin
                        state <= 3'b000;
                    end else if (in == 1'b1) begin
                        count <= count + 1'b1;
                    end
                end
            endcase
        end
    end
endmodule
