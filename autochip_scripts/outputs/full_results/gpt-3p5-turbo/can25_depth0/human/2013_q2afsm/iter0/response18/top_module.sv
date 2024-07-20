module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;

reg [1:0] current_state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

always @* begin
    case (current_state)
        A: begin
            if (r[2]) begin
                next_state = C;
            end else if (r[1]) begin
                next_state = B;
            end else if (r == 3'b000) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (r[1]) begin
                next_state = B;
            end else if (r == 3'b000) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        C: begin
            if (r[2]) begin
                next_state = C;
            end else if (r == 3'b000) begin
                next_state = A;
            end else begin
                next_state = C;
            end
        end
        D: begin
            if (r == 3'b000) begin
                next_state = D;
            end else begin
                next_state = A;
            end
        end
        default: next_state = A; // default to state A if undefined state
    endcase
end

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        g <= 3'b000;
    end else begin
        case (current_state)
            A: begin
                if (r[3]) begin
                    g <= 3'b100;
                end else if (r[2]) begin
                    g <= 3'b010;
                end else if (r[1]) begin
                    g <= 3'b001;
                end else begin
                    g <= 3'b000;
                end
            end
            B: begin
                if (r[3]) begin
                    g <= 3'b100;
                end else if (r[2]) begin
                    g <= 3'b010;
                end else if (r[1]) begin
                    g <= 3'b001;
                end else begin
                    g <= 3'b000;
                end
            end
            C: begin
                if (r[3]) begin
                    g <= 3'b100;
                end else if (r[2]) begin
                    g <= 3'b010;
                end else if (r[1]) begin
                    g <= 3'b001;
                end else begin
                    g <= 3'b000;
                end
            end
            D: g <= 3'b000;
            default: g <= 3'b000; // default to no grant if undefined state
        endcase
    end
end

endmodule
