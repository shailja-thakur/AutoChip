module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            3'b000: begin
                if (w == 1'b0) begin
                    next_state = 3'b010; // (0) --0--> B
                end else begin
                    next_state = 3'b000; // (0) --1--> A
                end
            end
            3'b001: begin
                if (w == 1'b0) begin
                    next_state = 3'b100; // (1) --0--> E
                end else begin
                    next_state = 3'b110; // (1) --1--> D
                end
            end
            3'b010: begin
                if (w == 1'b0) begin
                    next_state = 3'b001; // (0) --0--> C
                end else begin
                    next_state = 3'b110; // (0) --1--> D
                end
            end
            3'b011: begin
                if (w == 1'b0) begin
                    next_state = 3'b101; // (1) --0--> F
                end else begin
                    next_state = 3'b000; // (1) --1--> A
                end
            end
            3'b100: begin
                if (w == 1'b0) begin
                    next_state = 3'b100; // (1) --0--> E
                end else begin
                    next_state = 3'b110; // (1) --1--> D
                end
            end
            3'b101: begin
                if (w == 1'b0) begin
                    next_state = 3'b001; // (1) --0--> C
                end else begin
                    next_state = 3'b110; // (1) --1--> D
                end
            end
            3'b110: begin
                if (w == 1'b0) begin
                    next_state = 3'b010; // (1) --0--> B
                end else begin
                    next_state = 3'b000; // (1) --1--> A
                end
            end
            3'b111: begin
                if (w == 1'b0) begin
                    next_state = 3'b001; // (1) --0--> C
                end else begin
                    next_state = 3'b110; // (1) --1--> D
                end
            end
            default: next_state = 3'b000;
        endcase
    end

    assign z = (state == 3'b000 || state == 3'b011 || state == 3'b100 || state == 3'b101 || state == 3'b110 || state == 3'b111);

endmodule
