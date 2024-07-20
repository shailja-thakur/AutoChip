module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);
    
    reg [4:0] state;
    reg [4:0] count;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 0;
            count <= 0;
        end else begin
            case (state)
                0: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                    if (ground) begin
                        if (bump_left || (bump_left && bump_right)) begin
                            state <= 1;
                        end else if (dig) begin
                            state <= 2;
                        end else begin
                            state <= 0;
                        end
                    end else begin
                        aaah <= 1;
                        state <= 3;
                    end
                end
                1: begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                    if (ground) begin
                        if (bump_right || (bump_left && bump_right)) begin
                            walk_left <= 1;
                            walk_right <= 0;
                            state <= 0;
                        end else if (dig) begin
                            state <= 2;
                        end else begin
                            state <= 1;
                        end
                    end else begin
                        aaah <= 1;
                        state <= 3;
                    end
                end
                2: begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    if (ground) begin
                        if (bump_left || (bump_left && bump_right)) begin
                            state <= 1;
                        end else if (dig) begin
                            state <= 2;
                        end else begin
                            state <= 0;
                        end
                    end else if (dig && !ground) begin
                        digging <= 1;
                        state <= 2;
                    end else begin
                        aaah <= 1;
                        state <= 3;
                    end
                end
                3: begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                    if (ground) begin
                        state <= 0;
                    end else begin
                        state <= 3;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (areset) begin
            count <= 0;
        end else begin
            if (state == 3 && ground) begin
                count <= count + 1;
            end else begin
                count <= 0;
            end
        end
    end
    
    assign splatter = (state == 3 && count > 20);
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        $display("Simulation started");
    end
    
    always @(posedge clk) begin
        if (areset) begin
            $display("Reset triggered");
        end else if (splatter) begin
            $display("Splatter triggered");
        end
    end
    
endmodule
