module top_module (
    input [5:0] y,
    input w,
    output reg Y1,
    output reg Y3
);

    always @(*) begin
        // Default values
        Y1 = 0;
        Y3 = 0;

        case (y)
            6'b000001: begin // A
                if (w) begin
                    Y1 = 1; // Next state is B
                end
            end
            6'b000010: begin // B
                if (~w) begin
                    Y3 = 1; // Next state is D
                end
            end
            6'b000100: begin // C
                if (~w) begin
                    Y3 = 1; // Next state is D
                end
            end
            6'b001000: begin // D
                if (~w) begin
                    Y3 = 1; // Next state remains D
                end
            end
            6'b010000: begin // E
                if (~w) begin
                    Y3 = 1; // Next state is D
                end
            end
            6'b100000: begin // F
                if (~w) begin
                    Y3 = 1; // Next state is D
                end
            end
        endcase
    end

endmodule
