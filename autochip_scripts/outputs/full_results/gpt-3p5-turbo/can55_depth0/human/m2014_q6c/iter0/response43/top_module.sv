module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    wire Y2_next;
    wire Y4_next;

    assign Y2 = Y2_next;
    assign Y4 = Y4_next;

    always @* begin
        case (y)
            6'b000001: begin
                Y2_next = 1'b0;
                Y4_next = 1'b0;
            end
            6'b000010: begin
                Y2_next = 1'b0;
                Y4_next = 1'b1;
            end
            6'b000100: begin
                Y2_next = 1'b1;
                Y4_next = 1'b0;
            end
            6'b001000: begin
                Y2_next = 1'b1;
                Y4_next = 1'b1;
            end
            6'b010000: begin
                Y2_next = 1'b0;
                Y4_next = 1'b0;
            end
            6'b100000: begin
                Y2_next = 1'b1;
                Y4_next = w;
            end
            default: begin
                Y2_next = 1'b0;
                Y4_next = 1'b0;
            end
        endcase
    end

endmodule
