module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

    reg [2:0] state, next_state;
    reg [1:0] match_count;
    reg [1:0] wait_count;

    // State encoding
    localparam [2:0] A = 3'b000,
                     B = 3'b001,
                     C = 3'b010,
                     D = 3'b011,
                     E = 3'b100;

    // State transition and output logic
    always @(*)
    begin
        next_state = state;
        f = 1'b0;
        g = (state == D) ? 1'b1 : 1'b0;
        case (state)
            A: begin
                if (!resetn) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            B: begin
                f = 1'b1;
                next_state = C;
            end
            C: begin
                if (match_count == 2'b10) begin
                    next_state = D;
                end
            end
            D: begin
                if (y == 1'b1 || wait_count == 2'b10) begin
                    next_state = E;
                end
            end
            E: begin
                // Stay in this state indefinitely
                if (!resetn) begin
                    next_state = A;
                end
            end
        endcase
    end

    // State register and counters
    always @(posedge clk or negedge resetn)
    begin
        if (!resetn) begin
            state <= A;
            match_count <= 2'b00;
            wait_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == C) begin
                if ((match_count == 0 && x) || (match_count == 1 && !x) || (match_count == 2 && x)) begin
                    match_count <= match_count + 1;
                end else begin
                    match_count <= 0;
                end
            end else if (state == D) begin
                if (y) begin
                    wait_count <= 2'b00;
                end else begin
                    wait_count <= wait_count + 1;
                end
            end else begin
                match_count <= 2'b00;
                wait_count <= 2'b00;
            end
        end
    end

endmodule
